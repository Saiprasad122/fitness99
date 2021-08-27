<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Status;
use App\Models\Group;
use App\Models\UserGroup;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserGroupController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'User Group';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new UserGroup());

        $grid->column('id', __('Id'));
        $grid->column('group_id', __('Group'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
        $grid->column('user_id', __('User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('event_remainder', __('Event Remainder'))->display(function($types){
            if ($types == 1) {
                return "<span class='label label-success'>Yes</span>";
            } if ($types == 0) {
                return "<span class='label label-info'>No</span>";
            }
        });
        $grid->column('notification_status', __('Notification Status'))->display(function($status){
            $status_name = Status::where('id',$status)->value('status_name');
            if ($status == 1) {
                return "<span class='label label-success'>$status_name</span>";
            } else {
                return "<span class='label label-danger'>$status_name</span>";
            }
        });
        $grid->column('push_notification_status', __('Push notification Status'))->display(function($status){
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
            $event_users = User::pluck('user_name', 'id');
            $groups = Group::pluck('group_name', 'id');


            $filter->equal('event_remainder', 'Event Remainder')->select([1 => 'Yes', 0=> 'no']);
            $filter->equal('notification_status', 'Notification Status')->select($statuses);
            $filter->equal('push_notification_status', 'Notification Status')->select($statuses);
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
        $show = new Show(UserGroup::findOrFail($id));

        $show->field('id', __('Id'));
        $grid->column('user_id', __('User id'));
        $grid->column('group_id', __('Group Id'));
        $show->field('event_remainder', __('Event remainder'));
        $show->field('notification_status', __('Notification status'));
        $show->field('push_notification_status', __('Push notification status'));
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
        $form = new Form(new UserGroup());
        
        $statuses = Status::pluck('status_name', 'id');
        $event_users = User::pluck('user_name', 'id');
        $groups = Group::pluck('group_name', 'id');

        $form->select('user_id', __('User'))->options($event_users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('group_id', __('Group'))->options($groups)->rules(function ($form) {
                    return 'required';
                });
        $form->select('event_remainder', __('Event Remainder'))->options([1 => 'Yes', 0 => 'No'])->rules(function ($form) {
            return 'required';
        });
        $form->select('notification_status', __('Notification status'))->options($statuses)->default(1)->rules(function ($form) {
            return 'required';
        });
        $form->select('push_notification_status', __('Push notification status'))->options($statuses)->default(1)->rules(function ($form) {
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
