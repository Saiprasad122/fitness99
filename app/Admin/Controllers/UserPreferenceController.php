<?php

namespace App\Admin\Controllers;
use App\Models\User;
use App\Models\Status;
use App\Models\Preference;
use App\Models\UserPreference;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class UserPreferenceController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'User Preference';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new UserPreference());

        $grid->column('id', __('Id'));
        $grid->column('user_id', __('User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('sunday', __('Sunday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('monday', __('Monday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('tuesday', __('Tueday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('wednesday', __('Wednesday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('thursday', __('Thursday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('friday', __('Friday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
        });
        $grid->column('saturday', __('Saturday'))->display(function($status){
            if ($status == 1) {
                return "<span class='label label-warning'>Active</span>";
            } else {
                return "<span class='label label-info'>Inactive</span>";
            }
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
            $event_users = User::pluck('user_name', 'id');
            $preferences = Preference::pluck('preference', 'id');
            
            $filter->equal('preference_id', 'Preference')->select($preferences);
            $filter->equal('user_id', 'User')->select($event_users);
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
        $show = new Show(UserPreference::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User id'));
        $show->field('preference_id', __('Preference id'));
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
        $form = new Form(new UserPreference());
        
        $statuses = Status::pluck('status_name', 'id');
        $users = User::pluck('user_name', 'id');
        $preferences = Preference::pluck('preference', 'id');

         $form->select('user_id', __('User'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('sunday', __('Sunday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('sun_from_time', __('Sunday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('sun_to_time', __('Sunday To Time'))->rules(function ($form) {
                    return 'required';
                });        
        $form->select('monday', __('Monday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('mon_from_time', __('Monday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('mon_to_time', __('Monday To Time'))->rules(function ($form) {
                    return 'required';
                });        
        $form->select('tuesday', __('Tuesday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('tues_from_time', __('Tuesday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('tues_to_time', __('Tuesday To Time'))->rules(function ($form) {
                    return 'required';
                });        
        $form->select('wednesday', __('Wednesday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('wed_from_time', __('Wednesday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('wed_to_time', __('Wednesday To Time'))->rules(function ($form) {
                    return 'required';
                });      
        $form->select('thursday', __('Thursday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('thurs_from_time', __('Thursday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('thurs_to_time', __('Thursday To Time'))->rules(function ($form) {
                    return 'required';
                });   
        $form->select('friday', __('Friday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('fri_from_time', __('Friday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('fri_to_time', __('Friday To Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->select('saturday', __('Saturday'))->options([1 => 'Active', 2 => 'Inactive'])->rules(function ($form) {
                    return 'required';
                });
        $form->time('sat_from_time', __('Saturday From Time'))->rules(function ($form) {
                    return 'required';
                });
        $form->time('sat_to_time', __('Saturday To Time'))->rules(function ($form) {
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
