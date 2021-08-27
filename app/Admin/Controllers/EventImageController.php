<?php

namespace App\Admin\Controllers;
use App\Models\Event;
use App\Models\Status;
use App\Models\EventImage;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class EventImageController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Event Image';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new EventImage());

        $grid->column('id', __('Id'));
        $grid->column('event_id', __('Event'))->display(function($event_id){
            return Event::where('id',$event_id)->value('event_name');
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
            $events = Event::pluck('event_name', 'id');
            
            $filter->equal('event_id', 'Event')->select($events);
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
        $show = new Show(EventImage::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('event_id', __('Event id'));
        $show->field('image', __('Image'));
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
        $form = new Form(new EventImage());
        
        $events = Event::pluck('event_name', 'id');
        $statuses = Status::pluck('status_name', 'id');

        $form->select('event_id', __('Event'))->options($events)->rules(function ($form) {
                    return 'required';
                });
        $form->image('image', __('Image'))->uniqueName();
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
