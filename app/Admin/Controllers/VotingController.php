<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Status;
use App\Models\Group;
use App\Models\Voting;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class VotingController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Voting';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Voting());

        $grid->column('id', __('Id'));
        $grid->column('group_id', __('Group'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
       $grid->column('user_id', __('User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('total_users', __('Total Users'));
        $grid->column('accepted_count', __('Accepted Count'));
        $grid->column('rejected_count', __('Rejected Count'));
        $grid->column('rejected_reason', __('Rejected Reason'));
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
            $users = User::pluck('user_name', 'id');
            $groups = Group::pluck('group_name', 'Id');
            $filter->equal('group_id', 'Group')->select($groups);
            $filter->equal('user_id', 'User')->select($users);
            $filter->like('total_users', 'Total Users');
            $filter->like('accepted_count', 'Accepted Count');
            $filter->like('rejected_count', 'Rejected Count');
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
        $show = new Show(Voting::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('group_id', __('Group id'));
        $show->field('user_id', __('User id'));
        $show->field('total_users', __('Total users'));
        $show->field('accepted_count', __('Accepted count'));
        $show->field('rejected_count', __('Rejected count'));
        $show->field('rejected_reason', __('Rejected reason'));
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
        $form = new Form(new Voting());
        
        $statuses = Status::pluck('status_name', 'id');
        $users = User::pluck('user_name', 'id');
        $groups = Group::pluck('group_name', 'id');

         $form->select('group_id', __('Group'))->options($groups)->rules(function ($form) {
                    return 'required';
                });
         $form->select('user_id', __('User'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->text('total_users', __('Total Users'))->rules(function ($form) {
                    return 'numeric|max:250';
                });
        $form->text('accepted_count', __('Accepted Count'))->rules(function ($form) {
                    return 'numeric|max:250';
                });
        $form->text('rejected_count', __('Rejected Count'))->rules(function ($form) {
                    return 'numeric|max:250';
                });
        $form->textarea('rejected_reason', __('Rejected Reason'))->rules(function ($form) {
                    return ;
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
