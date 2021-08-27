<?php

namespace App\Admin\Controllers;

use App\Models\User;
use App\Models\Package;
use App\Models\PaymentMode;
use App\Models\Status;
use App\Models\Subscription;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class SubscriptionController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Subscription';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Subscription());

        $grid->column('id', __('Id'));
        $grid->column('user_id', __('User'))->display(function($user_id){
            return User::where('id',$user_id)->value('user_name');
        });
        $grid->column('package_id', __('Package'))->display(function($package_id){
            return Package::where('id',$package_id)->value('package_name');
        });
        $grid->column('payment_mode', __('Payment Mode'))->display(function($payment_mode){
            return PaymentMode::where('id',$payment_mode)->value('payment_name');
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
            $packages = Package::pluck('package_name', 'id');
            $payment_modes = PaymentMode::pluck('payment_name', 'id');
            $statuses = Status::pluck('status_name', 'id');

            $filter->equal('user_id', 'User Id')->select($users);
            $filter->equal('package_id', 'Package Id')->select($packages);
            $filter->equal('payment_mode', 'Payment Mode')->select($payment_modes);
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
        $show = new Show(Subscription::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('user_id', __('User Id'));
        $show->field('package_id', __('Package Id'));
        $show->field('payment_mode', __('Payment Mode'));
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
        $form = new Form(new Subscription());

        $users = User::pluck('user_name', 'id');
        $packages = Package::pluck('package_name', 'id');
        $payment_modes = PaymentMode::pluck('payment_name', 'id');
        $statuses = Status::pluck('status_name', 'id');


        $form->select('user_id', __('User'))->options($users)->rules(function ($form) {
                    return 'required';
                });
        $form->select('package_id', __('Package'))->options($packages)->rules(function ($form) {
                    return 'required';
                });
        $form->select('payment_mode', __('Payment Mode'))->options($payment_modes)->rules(function ($form) {
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
