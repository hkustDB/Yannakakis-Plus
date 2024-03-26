create or replace view aggView1358714863826070605 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6689579935764562236 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1358714863826070605 where mk.movie_id=aggView1358714863826070605.v12;
create or replace view aggView3946684000225912951 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8820395134248425375 as select v12, v31 from aggJoin6689579935764562236 join aggView3946684000225912951 using(v18);
create or replace view aggView3172685798469877663 as select v12, MIN(v31) as v31 from aggJoin8820395134248425375 group by v12;
create or replace view aggJoin5570810119057298352 as select company_id as v1, v31 from movie_companies as mc, aggView3172685798469877663 where mc.movie_id=aggView3172685798469877663.v12;
create or replace view aggView5402186770850666631 as select v1, MIN(v31) as v31 from aggJoin5570810119057298352 group by v1;
create or replace view aggJoin7532128553502688576 as select country_code as v3, v31 from company_name as cn, aggView5402186770850666631 where cn.id=aggView5402186770850666631.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin7532128553502688576;
