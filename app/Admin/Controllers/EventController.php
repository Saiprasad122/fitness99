<?php

namespace App\Admin\Controllers;
use App\Models\Status;
use App\Models\Event;
use App\Models\User;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class EventController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Event';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Event());

        $grid->column('id', __('Id'));
        $grid->column('event_name', __('Event Name'));
        $grid->column('time', __('Time'));
        $grid->column('hours', __('Hours'));
        $grid->column('location_name', __('Location Name'));
        $grid->column('date', __('Date'));
        $grid->column('created_by', __('Created By'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('status', __('Status'))->display(function($status){
            $status_name = Status::where('id',$status)->value('status_name');
            if ($status == 1) {
                return "<span class='label label-success'>$status_name</span>";
            } else {
                return "<span class='label label-danger'>$status_name</span>";
            }
        });
        $grid->disableExport();
        $grid->actions(function ($actions) {
            $actions->disableView();
        });

         $grid->filter(function ($filter) {
            //Get All status
            $statuses = Status::pluck('status_name', 'id');

            $filter->like('event_name', 'Event Name');
            $filter->like('time', 'Time');
            $filter->like('hours', 'Hours');
            $filter->like('location_name', 'Location Name');
            $filter->like('date', 'Date');
            $filter->equal('status', 'Status')->select($statuses);
        });


        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(Event::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('event_name', __('Event name'));
        $show->field('time', __('Time'));
        $show->field('hours', __('Hours'));
        $show->field('description', __('Description'));
        $show->field('location_name', __('Location name'));
        $show->field('date', __('Date'));
        $show->field('created_by', __('Created by'));
        $show->field('status', __('Status'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new Event());
        $statuses = Status::pluck('status_name', 'id');
        $users = User::pluck('user_name', 'id');

        $form->text('event_name', __('Event Name'));
        $form->time('time', __('Time'))->default(date('H:i:s'))->rules(function ($form) {
                    return 'required';
                });
        $form->text('hours', __('Hours'))->rules(function ($form) {
                    return 'required';
                });
        $form->textarea('description', __('Description'))->rules(function ($form) {
                    return 'required';
                });
        $form->text('location_name', __('Location Name'))->rules(function ($form) {
                    return 'required';
                });
        $form->date('date', __('Date'))->default(date('Y-m-d'));
        $form->select('created_by', __('Created By'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('status', __('Status'))->options($statuses)->default(1)->rules(function ($form) {
            return 'required';
        });
        $form->tools(function (Form\Tools $tools) {
            $tools->disableDelete(); 
            $tools->disableView();
        });
        $form->footer(function ($footer) {
            $footer->disableViewCheck();
            $footer->disableEditingCheck();
            $footer->disableCreatingCheck();
        });

        return $form;
    }
}
