<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\InviteStatus;
use App\Models\Group;
use App\Models\GroupInvitation;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupInvitationController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group Invitations';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupInvitation());

        $grid->column('id', __('Id'));
        
        $grid->column('group_id', __('Group'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
        $grid->column('from_user_id', __('From User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('to_user_id', __('To User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('invite_message', __('Invite Message'));
         $grid->column('status', __('Status'))->display(function($status){
            $status_name = InviteStatus::where('id',$status)->value('status_name');
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
            $statuses = InviteStatus::pluck('status_name', 'id');
            $event_users = User::pluck('user_name', 'id');
            
            $filter->equal('from_user_id', 'From User')->select($event_users);
            $filter->equal('to_user_id', 'To User')->select($event_users);
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
        $show = new Show(GroupInvitation::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('from_user_id', __('From user id'));
        $show->field('to_user_id', __('To user id'));
        $show->field('invite_message', __('Invite message'));
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
        $form = new Form(new GroupInvitation());

        $statuses = InviteStatus::pluck('status_name', 'id');
        $event_users = User::pluck('user_name', 'id');
        $groups = Group::pluck('group_name', 'id');
        
        $form->select('group_id', __('Group'))->options($groups)->rules(function ($form) {
                    return 'required';
                });
        $form->select('from_user_id', __('From User'))->options($event_users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('to_user_id', __('To User'))->options($event_users)->rules(function ($form) {
                    return 'required';
                });
        $form->textarea('invite_message', __('Invite Message'))->rules(function ($form) {
            return 'required|max:250';
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
