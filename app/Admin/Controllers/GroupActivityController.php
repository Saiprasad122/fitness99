<?php

namespace App\Admin\Controllers;
use App\Models\Status;
use App\Models\Day;
use App\Models\GroupActivity;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupActivityController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group Activity';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupActivity());

        $grid->column('id', __('Id'));
        $grid->column('activity_title', __('Activity Title'));
        $grid->column('day', __('Day'))->display(function($days){
            $day = Day::where('id',$days)->value('day');
                return "$day";
        });
        $grid->column('from_time', __('From Time'));
        $grid->column('to_time', __('To Time'));
        //$grid->column('activity_description', __('Activity Description'));
        //$grid->column('activity_location', __('Activity Location'));
        //$grid->column('additional_notes', __('Additional Notes'));
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
            
            $filter->like('activity_title', 'Activity title');
            $filter->like('activity_location', 'Activity location');
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
        $show = new Show(GroupActivity::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('activity_title', __('Activity title'));
        $show->field('activity_description', __('Activity description'));
        $show->field('activity_location', __('Activity location'));
        $show->field('additional_notes', __('Additional notes'));
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
        $form = new Form(new GroupActivity());

        $statuses = Status::pluck('status_name', 'id');
        $days = Day::pluck('day', 'id');

        $form->text('activity_title', __('Activity Title'))->rules(function ($form) {
            return 'required';
        });
        $form->textarea('activity_description', __('Activity Description'))->rules(function ($form) {
            return 'required';
        });
        $form->textarea('activity_location', __('Activity Location'))->rules(function ($form) {
            return 'required';
        });
        $form->textarea('additional_notes', __('Additional Notes'))->rules(function ($form) {
            return 'required';
        });
        $form->select('day', __('Day'))->options($days)->default(1)->rules(function ($form) {
            return 'required';
        });
        $form->time('from_time', __('From Time'))->rules(function ($form) {
            return 'required';
        });
        $form->time('to_time', __('To Time'))->rules(function ($form) {
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
