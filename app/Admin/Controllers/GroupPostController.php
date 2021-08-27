<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Status;
use App\Models\GroupPost;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupPostController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group Post';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupPost());

        $grid->column('id', __('Id'));
        $grid->column('post_type', __('Post Type'));
        $grid->column('upload_by', __('Upload By'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('reporting_count', __('Reporting Count'));
        $grid->column('content', __('Content'));
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
            
            $filter->equal('upload_by', 'Upload By')->select($users);
            $filter->like('post_type', 'Post Type');
            $filter->like('reporting_count', 'Reporting Count');
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
        $show = new Show(GroupPost::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('post_type', __('Post type'));
        $show->field('upload_by', __('Upload by'));
        $show->field('reporting_count', __('Reporting count'));
        $show->field('content', __('Content'));
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
        $form = new Form(new GroupPost());
        
        $statuses = Status::pluck('status_name', 'id');
        $users = User::pluck('user_name', 'id');

        $form->text('post_type', __('Post Type'))->rules(function ($form) {
                    return 'required';
                });
        $form->select('upload_by', __('Upload By'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->text('reporting_count', __('Reporting Count'))->rules(function ($form) {
                    return 'numeric|max:250';
                });
        $form->textarea('content', __('Content'))->rules(function ($form) {
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
