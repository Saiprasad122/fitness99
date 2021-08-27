<?php

namespace App\Admin\Controllers;
use App\Models\Group;
use App\Models\GroupTiming;
use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class GroupTimingController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Group Timing';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new GroupTiming());

        $grid->column('id', __('Id'));
        $grid->column('group_id', __('Group'))->display(function($group_id){
            return Group::where('id',$group_id)->value('group_name');
        });
        $grid->column('monday', __('Monday'));
        $grid->column('monday_no_of_hours', __('No of hours'));
        $grid->column('tuesday', __('Tuesday'));
        $grid->column('tuesday_no_of_hours', __('No of hours'));
        $grid->column('wednesday', __('Wednesday'));
        $grid->column('wednesday_no_of_hours', __('No of hours'));
        $grid->column('thursday', __('Thursday'));
        $grid->column('thursday_no_of_hours', __('No of hours'));
        $grid->column('friday', __('Friday'));
        $grid->column('friday_no_of_hours', __('No of hours'));
        $grid->column('saturday', __('Saturday'));
        $grid->column('saturday_no_of_hours', __('No of hours'));
        $grid->column('sunday', __('Sunday'));
        $grid->column('sunday_no_of_hours', __('No of hours'));
        

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
        $show = new Show(GroupTiming::findOrFail($id));

        $show->field('id', __('Id'));
        $show->field('group_id', __('Group id'));
        $show->field('monday', __('Monday'));
        $show->field('monday_no_of_hours', __('No of hours'));
        $show->field('tuesday', __('Tuesday'));
        $show->field('tuesday_no_of_hours', __('No of hours'));
        $show->field('wednesday', __('Wednesday'));
        $show->field('wednesday_no_of_hours', __('No of hours'));
        $show->field('thursday', __('Thursday'));
        $show->field('thursday_no_of_hours', __('No of hours'));
        $show->field('friday', __('Friday'));
        $show->field('friday_no_of_hours', __('No of hours'));
        $show->field('saturday', __('Saturday'));
        $show->field('saturday_no_of_hours', __('No of hours'));
        $show->field('sunday', __('Sunday'));
        $show->field('sunday_no_of_hours', __('No of hours'));
        $grid->disableExport();
        $grid->actions(function ($actions) {
            $actions->disableView();
        });

         $grid->filter(function ($filter) {
            //Get All status
            
            $groups = Group::pluck('group_name', 'Id');
            $filter->equal('group_id', 'Group')->select($groups);
           
            $filter->like('monday', 'Monday');
            $filter->like('tuesday', 'tuesday');
            $filter->like('wednesday', 'wednesday');
            $filter->like('thursday', 'thursday');
            $filter->like('friday', 'friday');
            $filter->like('saturday', 'saturday');
            $filter->like('sunday', 'sunday');
            
        });


        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new GroupTiming());

        $groups = Group::pluck('group_name', 'id');

       $form->select('group_id', __('Group'))->options($groups)->rules(function ($form) {
                    'required|max:250';
                });
        $form->time('monday', __('Monday'))->format('hh:mm A');
        $form->text('monday_no_of_hours', __('No of hours'));
        $form->time('tuesday', __('Tuesday'))->format('hh:mm A');
        $form->text('tuesday_no_of_hours', __('No of hours'));
        $form->time('wednesday', __('Wednesday'))->format('hh:mm A');
        $form->text('wednesday_no_of_hours', __('No of hours'));
        $form->time('thursday', __('Thursday'))->format('hh:mm A');
        $form->text('thursday_no_of_hours', __('Thursday no of hours'));
        $form->time('friday', __('Friday'))->format('hh:mm A');
        $form->text('friday_no_of_hours', __('No of hours'));
        $form->time('saturday', __('Saturday'))->format('hh:mm A');
        $form->text('saturday_no_of_hours', __('No of hours'));
        $form->time('sunday', __('Sunday'))->format('hh:mm A');
        $form->text('sunday_no_of_hours', __('No of hours'));
        
         $form->saving(function ($form) {
            $form->monday = date('H:i:s', strtotime($form->monday));
            $form->tuesday = date('H:i:s', strtotime($form->tuesday));
            $form->wednesday = date('H:i:s', strtotime($form->wednesday));
            $form->thursday = date('H:i:s', strtotime($form->thursday));
            $form->friday = date('H:i:s', strtotime($form->friday));
            $form->saturday = date('H:i:s', strtotime($form->saturday));
            $form->sunday = date('H:i:s', strtotime($form->sunday));
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
