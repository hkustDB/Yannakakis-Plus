create or replace view aggJoin646294523390710181 as (
with aggView8065202045248434953 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView8065202045248434953 where ci.person_id=aggView8065202045248434953.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6675064256082806471 as (
with aggView4815087165408589585 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4815087165408589585 where mi_idx.info_type_id=aggView4815087165408589585.v17);
create or replace view aggJoin7914490502565314554 as (
with aggView4268141004065232508 as (select v49, MIN(v35) as v62 from aggJoin6675064256082806471 group by v49)
select id as v49, title as v50, v62 from title as t, aggView4268141004065232508 where t.id=aggView4268141004065232508.v49);
create or replace view aggJoin6189322943557419867 as (
with aggView3772666608150783734 as (select v49, MIN(v62) as v62, MIN(v50) as v64 from aggJoin7914490502565314554 group by v49,v62)
select movie_id as v49, keyword_id as v19, v62, v64 from movie_keyword as mk, aggView3772666608150783734 where mk.movie_id=aggView3772666608150783734.v49);
create or replace view aggJoin1703480246058219135 as (
with aggView2131032083184280537 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v49, v62, v64 from aggJoin6189322943557419867 join aggView2131032083184280537 using(v19));
create or replace view aggJoin3381688812880175062 as (
with aggView4682992242511638847 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView4682992242511638847 where mi.info_type_id=aggView4682992242511638847.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin2201967204727260177 as (
with aggView1827374472128372822 as (select v49, MIN(v30) as v61 from aggJoin3381688812880175062 group by v49)
select v49, v62 as v62, v64 as v64, v61 from aggJoin1703480246058219135 join aggView1827374472128372822 using(v49));
create or replace view aggJoin8510159336915260976 as (
with aggView5823612682039223823 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView5823612682039223823 where mc.company_id=aggView5823612682039223823.v8);
create or replace view aggJoin6677816894954272668 as (
with aggView5871467297607326414 as (select v49 from aggJoin8510159336915260976 group by v49)
select v49, v62 as v62, v64 as v64, v61 as v61 from aggJoin2201967204727260177 join aggView5871467297607326414 using(v49));
create or replace view aggJoin7220217420065929918 as (
with aggView5087699119223560679 as (select v49, MIN(v63) as v63 from aggJoin646294523390710181 group by v49,v63)
select v62 as v62, v64 as v64, v61 as v61, v63 from aggJoin6677816894954272668 join aggView5087699119223560679 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin7220217420065929918;
