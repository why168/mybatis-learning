package com.why168.domain;

import java.io.Serializable;
import java.util.List;

public class Dept implements Serializable {

    private Integer did;
    private String deptName;
    private List<Emp> emps;

    @Override
    public String toString() {
        return "Dept{" + "did=" + did + ", deptName='" + deptName + '\'' + ", emps=" + emps + '}';
    }

    public List<Emp> getEmps() {
        return emps;
    }

    public void setEmps(List<Emp> emps) {
        this.emps = emps;
    }

    public Integer getDid() {
        return did;
    }

    public void setDid(Integer did) {
        this.did = did;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Dept() {
    }

    public Dept(Integer did, String deptName) {
        this.did = did;
        this.deptName = deptName;
    }
}
