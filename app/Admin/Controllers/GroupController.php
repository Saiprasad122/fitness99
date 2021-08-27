<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Status;
use App\Models\Group;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Group());

        $grid->column('id', __('Id'));
        $grid->column('created_by', __('Created By'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        
        $grid->column('group_name', __('Group Name'));
        $grid->column('active_members', __('Active Members'));
        $grid->column('max_group_members', __('Max Group Members'));
        $grid->column('goal', __('Goal'));
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
            $statuses = Status::pluck('status_name', 'Id');
            $users = User::pluck('user_name', 'id');

            $filter->equal('user_id', 'User')->select($users);
            $filter->like('group_name', 'Group Name');
            $filter->like('active_members', 'Active Members');
            $filter->like('max_group_members', 'Max Group Members');
            $filter->like('location', 'Location');
            $filter->like('radius', 'Radius');
            $filter->like('goal', 'Goal');
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
        $show = new Show(Group::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User id'));
        $show->field('group_name', __('Group name'));
        $show->field('active_members', __('Active members'));
        $show->field('goal', __('Goal'));
        $show->field('group_image', __('Group image'));
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
        $form = new Form(new Group());

        $statuses = Status::pluck('status_name', 'id');
        $users = User::pluck('user_name', 'id');

        $form->select('created_by', __('Created_by'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->text('group_name', __('Group Name'))->rules(function ($form) {
            return 'required|max:250';
        });
        $form-> text('active_members', __('Active Members'))->rules(function ($form) {
                return 'numeric|max:150';
        });
        $form-> text('max_group_members', __('Max Group Members'))->rules(function ($form) {
                return 'numeric|max:150';
        });
        $form-> textarea('location', __('Location'))->rules(function ($form) {
                return 'required';
        });
        $form->text('goal', __('Goal'))->rules(function ($form) {
            return 'required|max:250';
        });
         $form->text('zip_code', __('Zipcode'))->rules(function ($form) {
            return 'required|max:250';
        });
         $form->textarea('last_message', __('Last Message'))->rules(function ($form) {
            return 'required';
        });
        $form->image('group_image', __('Group Image'))->uniqueName();
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
