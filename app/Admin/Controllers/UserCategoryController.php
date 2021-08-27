<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\Category;
use App\Models\Status;
use App\Models\UserCategory;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserCategoryController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'User Category';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new UserCategory());

        $grid->column('id', __('Id'));
        $grid->column('user_id', __('User Id'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('category_id', __('Category Id'))->display(function($category_id){
            return Category::where('id',$category_id)->value('category_name');
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
            $users = User::pluck('user_name', 'id');
            $categories = Category::pluck('category_name', 'id');
            $statuses = Status::pluck('status_name', 'id');

            $filter->like('group_name', 'Group Name');
            $filter->equal('user_id', 'User Id')->select($users);
            $filter->equal('category_id', 'Category Id')->select($categories);
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
        $show = new Show(UserCategory::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User id'));
        $show->field('category_id', __('Category id'));
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
        $form = new Form(new UserCategory());

        $users = User::pluck('user_name', 'id');
        $categories = Category::pluck('category_name', 'id');
        $statuses = Status::pluck('status_name', 'id');


        $form->select('user_id', __('User Id'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('category_id', __('Category Id'))->options($categories)->rules(function ($form) {
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
