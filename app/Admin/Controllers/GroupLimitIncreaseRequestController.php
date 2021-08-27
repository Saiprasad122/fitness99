<?php

namespace App\Admin\Controllers;
use App\Models\Status;
use App\Models\Group;
use App\Models\GroupLimitIncreaseRequest;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupLimitIncreaseRequestController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group Limit Increase Request';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupLimitIncreaseRequest());

        $grid->column('id', __('Id'));
        $grid->column('group_id', __('Group'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
        $grid->column('existing_count', __('Existing count'));
        $grid->column('requesting_count', __('Requesting count'));
        $grid->column('requested_by', __('Requested by'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('status', __('Status'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Pending for Approval</span>";
            } if ($status == 2)  {
                return "<span class='label label-success'>Approval</span>";
            } else {
                return "<span class='label label-danger'>Rejected</span>";
            }
        });
        $grid->disableExport();
        $grid->actions(function ($actions) {
            $actions->disableView();
        });

         $grid->filter(function ($filter) {
            //Get All status
            $statuses = Status::pluck('status_name', 'id');
            $groups = Group::pluck('group_name', 'Id');

            $filter->equal('group_id', 'Group')->select($groups);
            $filter->like('existing_count', 'Existing count');
            $filter->like('requested_by', 'Requested by');
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
        $show = new Show(GroupLimitIncreaseRequest::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('group_id', __('Group id'));
        $show->field('existing_count', __('Existing count'));
        $show->field('requested_by', __('Requested by'));
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
        $form = new Form(new GroupLimitIncreaseRequest());
        $statuses = Status::pluck('status_name', 'id');
        $groups = Group::pluck('group_name', 'Id');
        $users = User::pluck('user_name', 'id');

        $form->select('group_id', __('Group'))->options($groups)->rules(function ($form) {
                    return 'required';
                });
        $form->text('existing_count', __('Existing count'))->rules(function ($form) {
                    return 'numeric|max:250';
                });
        $form->text('requesting_count', __('Requesting count'))->rules(function ($form) {
                    return 'numeric|max:250';
                }); 
        $form->textarea('comment', __('Comment'))->rules(function ($form) {
                    return 'required';
                });
        $form->text('requested_by', __('Requested by'))->options($users)->rules(function ($form) {
                    return 'required';
                });
       $form->select('status', __('Status'))->options([1 => 'Pending for approval', 2 => 'Approval', 3 => 'Rejected'])->rules(function ($form) {
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
