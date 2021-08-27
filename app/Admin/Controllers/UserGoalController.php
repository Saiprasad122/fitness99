<?php

namespace App\Admin\Controllers;
use App\Models\EventUser;
use App\Models\Status;
use App\Models\Goal;
use App\Models\UserGoal;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserGoalController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'UserGoal';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new UserGoal());

        $grid->column('id', __('Id'));
        $grid->column('user_id', __('User Id'))->display(function($user_id){
            return EventUser::where('id',$user_id)->value('user_name');
        });
        $grid->column('goal_id', __('Goal Id'))->display(function($goal_id){
            return Goal::where('id',$goal_id)->value('goal_name');
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
            $statuses = Status::pluck('status_name', 'id');
            $event_users = EventUser::pluck('user_name', 'id');
            $goals = Goal::pluck('goal_name', 'id');
            $filter->equal('goal_id', 'Goal Id')->select($goals);
            $filter->equal('user_id', 'User Id')->select($event_users);
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
        $show = new Show(UserGoal::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User id'));
        $show->field('goal_id', __('Goal id'));
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
        $form = new Form(new UserGoal());
        
        $statuses = Status::pluck('status_name', 'id');
        $event_users = EventUser::pluck('user_name', 'id');
        $goals = Goal::pluck('goal_name', 'id');
       $form->select('user_id', __('User id'))->options($event_users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('goal_id', __('Goal id'))->options($goals)->rules(function ($form) {
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
