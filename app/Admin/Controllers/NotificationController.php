<?php

namespace App\Admin\Controllers;


use App\Models\User;
use App\Models\NotificationType;
use App\Models\Status;
use App\Models\Notification;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class NotificationController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Notification';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Notification());

        $grid->column('id', __('Id'));
        $grid->column('ref_id', __('Reference'))->display(function($ref_id){
            return User::where('id',$ref_id)->value('user_name');
        });
        $grid->column('notification_type', __('Notification Type'))->display(function($notification_type){
            return NotificationType::where('id',$notification_type)->value('type');
        });
        $grid->column('title', __('Title'));
        
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
            $notification_types = NotificationType::pluck('type', 'id');
            $statuses = Status::pluck('status_name', 'id');

            $filter->like('title', 'Title');
            $filter->like('description', 'Description');
            $filter->equal('ref_id', 'Ref Id')->select($users);
            $filter->equal('notification_type', 'Notification Type')->select($notification_types);
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
        $show = new Show(Notification::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('ref_id', __('Ref Id'));
        $show->field('notification_type', __('Notification Type'));
        $show->field('title', __('Title'));
        $show->field('description', __('Description'));
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
        $form = new Form(new Notification());
        
        $users = User::pluck('user_name', 'id');
        $notification_types = NotificationType::pluck('type', 'id');
        $statuses = Status::pluck('status_name', 'id');

        $form->select('ref_id', __('Reference'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('notification_type', __('Notification Type'))->options($notification_types)->rules(function ($form) {
                    return 'required';
                });
        $form->text('title', __('Title'));
        $form->textarea('description', __('Description'));
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
