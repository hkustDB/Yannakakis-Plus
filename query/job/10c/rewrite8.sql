create or replace view aggJoin3010413673440023219 as (
with aggView1143894912747378260 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView1143894912747378260 where ci.person_role_id=aggView1143894912747378260.v1 and note LIKE '%(producer)%');
create or replace view aggJoin2803198164767990758 as (
with aggView3530299843175947615 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView3530299843175947615 where mc.company_type_id=aggView3530299843175947615.v22);
create or replace view aggJoin5293848957032074655 as (
with aggView2542469478434599981 as (select id as v29 from role_type as rt)
select v31, v12, v43 from aggJoin3010413673440023219 join aggView2542469478434599981 using(v29));
create or replace view aggJoin5248317175283064442 as (
with aggView2140688434551686083 as (select v31, MIN(v43) as v43 from aggJoin5293848957032074655 group by v31,v43)
select id as v31, title as v32, production_year as v35, v43 from title as t, aggView2140688434551686083 where t.id=aggView2140688434551686083.v31 and production_year>1990);
create or replace view aggJoin6838044824550219913 as (
with aggView1570575048409907029 as (select v31, MIN(v43) as v43, MIN(v32) as v44 from aggJoin5248317175283064442 group by v31,v43)
select v15, v43, v44 from aggJoin2803198164767990758 join aggView1570575048409907029 using(v31));
create or replace view aggJoin3370712942360247649 as (
with aggView282547318542792835 as (select id as v15 from company_name as cn where country_code= '[us]')
select v43, v44 from aggJoin6838044824550219913 join aggView282547318542792835 using(v15));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin3370712942360247649;
