<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\Category;
use App\Models\Status;
use App\Models\GroupCategory;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupCategoryController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'GroupCategory';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupCategory());

        $grid->column('id', __('Id'));
        $grid->column('group_id', __('Group Id'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
        $grid->column('category_id', __('Category Id'))->display(function($category_id){
            return Category::where('id',$category_id)->value('category_name');
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
        $show = new Show(GroupCategory::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User Id'));
        $show->field('category_id', __('Category Id'));
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
        $form = new Form(new GroupCategory());
        
        $group = Group::pluck('group_name', 'id');
        $categories = Category::pluck('category_name', 'id');
        $statuses = Status::pluck('status_name', 'id');

        $form->select('group_id', __('Group Id'))->options($group)->rules(function ($form) {
                    return 'required';
                });
        $form->select('category_id', __('Category Id'))->options($categories)->rules(function ($form) {
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
