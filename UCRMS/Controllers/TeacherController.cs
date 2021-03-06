﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UCRMS.BLL;
using UCRMS.Models.EntityModels;
using UCRMS.Models.ViewModels;

namespace UCRMS.Controllers
{
    public class TeacherController : Controller
    {
        DesignationManager _designationManager = new DesignationManager();
        DepartmentManager _departmentManager = new DepartmentManager();
        TeacherManager _teacherManager = new TeacherManager();
        CourseManager _courseManager = new CourseManager();

        // GET: Teacher
        [HttpGet]
        public ActionResult Save()
        {
            var designations = _designationManager.GetAll() ?? new List<Designation>();
            var departments = _departmentManager.GetAll() ?? new List<Department>();
            ViewBag.Designations = new SelectList(designations, "Id", "Name");
            ViewBag.Departments = new SelectList(departments, "Id", "Name");
            return View();
        }

        [HttpPost]
        public ActionResult Save(Teacher teacher)
        {
            var designations = _designationManager.GetAll() ?? new List<Designation>();
            var departments = _departmentManager.GetAll() ?? new List<Department>();
            ViewBag.Designations = new SelectList(designations, "Id", "Name");
            ViewBag.Departments = new SelectList(departments, "Id", "Name");

            if (ModelState.IsValid)
            {
                ArrayList status = _teacherManager.Save(teacher);
                ViewBag.Status = status;
                if ((bool) status[0])
                {
                    ModelState.Clear();
                    return View(); 
                }
                return View(teacher);
            }

            return View(teacher);
        }

        [HttpGet]
        public ActionResult AssignCourse()
        {
            var departments = _departmentManager.GetAll() ?? new List<Department>();
            ViewBag.Departments = new SelectList(departments, "Id", "Name");
            return View();
        }


        [HttpPost]
        public ActionResult AssignCourse(TeacherCourse teacherCourse)
        {
            var departments = _departmentManager.GetAll() ?? new List<Department>();
            ViewBag.Departments = new SelectList(departments, "Id", "Name");

            if (ModelState.IsValid)
            {
                ArrayList status = _teacherManager.AssignCourse(teacherCourse);
                ViewBag.Status = status;
                if ((bool) status[0])
                {
                    ModelState.Clear();
                    return View();
                }
                return View(teacherCourse);
            }
            return View(teacherCourse);
        }

        public JsonResult GetAllTeacherAndCourseByDepartmentId(int departmentId)
        {
            var teachers = _teacherManager.GetAllTeacherByDepartmentId(departmentId);
            var courses = _courseManager.GetAllCourseByDepartmentId(departmentId);
            var teachersAndCourses = new
            {
                Teachers = teachers,
                Courses = courses
            };
            return Json(teachersAndCourses, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetTeacherCourseCreditInfoByTeacherId(int teacherId)
        {
            var teacher = _teacherManager.GetTeacherCourseCreditInfoByTeacherId(teacherId);
            return Json(teacher, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseInfoByCourseId(int courseId)
        {
            var course = _courseManager.GetCourseInfoByCourseId(courseId);
            return Json(course, JsonRequestBehavior.AllowGet);
        }
    }
}