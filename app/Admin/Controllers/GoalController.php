<?php

namespace App\Admin\Controllers;
use App\Models\Status;
use App\Models\Goal;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GoalController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Goal';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Goal());

        $grid->column('id', __('Id'));
        $grid->column('goal_name', __('Goal Name'));
        $grid->column('from_date', __('From Date'));
        $grid->column('to_date', __('To Date'));
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
            $filter->like('goal_name', 'Goal Name');
            $filter->like('from_date', 'From Date');
            $filter->like('to_date', 'To Date');
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
        $show = new Show(Goal::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('goal_name', __('Goal name'));
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
        $form = new Form(new Goal());

        $statuses = Status::pluck('status_name', 'id');

        $form->text('goal_name', __('Goal Name'))->rules(function ($form) {
            return 'required|max:250';
        });
        $form->date('from_date', __('From Date'))->default(date('Y-m-d'))->rules(function ($form) {
            return 'required';
        });
        $form->date('to_date', __('To Date'))->default(date('Y-m-d'))->rules(function ($form) {
            return 'required';
        });
         $form->textarea('description', __('Description'))->rules(function ($form) {
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
