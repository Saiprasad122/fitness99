<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Activity;
use App\Models\Day;
use App\Models\Status;
use App\Models\UserActivity;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserActivityController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'User Activity';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new UserActivity());

        $grid->column('id', __('Id'));
        $grid->column('user_id', __('User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('activity_id', __('Activity'))->display(function($activity_id){
            return Activity::where('id',$activity_id)->value('activity_name');
        });
        $grid->column('day_id', __('Day'))->display(function($day_id){
            return Day::where('id',$day_id)->value('day');
        });
        $grid->column('from_time', __('From Time'));
        $grid->column('to_time', __('To Time'));
        $grid->column('total_hours', __('Total Hours'));
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
            $activities = Activity::pluck('activity_name', 'id');
            $days = Day::pluck('day', 'id');
            $event_users = User::pluck('user_name', 'id');
            
            $filter->equal('activity_id', 'Activity')->select($activities);
            $filter->equal('day_id', 'Day')->select($days);
            $filter->equal('user_id', 'User')->select($event_users);
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
        $show = new Show(UserActivity::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User id'));
        $show->field('activity_id', __('Activity id'));
        $show->field('day_id', __('Day id'));
        $show->field('from_time', __('From time'));
        $show->field('to_time', __('To time'));
        $show->field('total_hours', __('Total hours'));
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
        $form = new Form(new UserActivity());

        $statuses = Status::pluck('status_name', 'id');
        $activities = Activity::pluck('activity_name', 'id');
        $days = Day::pluck('day', 'id');
        $event_users = User::pluck('user_name', 'id');

         $form->select('user_id', __('User'))->options($event_users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('activity_id', __('Activity'))->options($activities)->rules(function ($form) {
                    return 'required';
                });
        $form->select('day_id', __('Day'))->default(date('Y-m-d'))->options($days)->rules(function ($form) {
                    return 'required';
                });
        $form->time('from_time', __('From Time'))->default(date('H:i:s'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('to_time', __('To Time'))->default(date('H:i:s'))->rules(function ($form) {
                    return 'required';
                });
        $form->decimal('total_hours', __('Total hours'))->rules(function ($form) {
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
