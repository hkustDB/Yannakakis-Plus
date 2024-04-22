create or replace view aggView2919388054719129097 as select name as v41, id as v40 from name as n;
create or replace view aggJoin7448837027195541303 as (
with aggView8206370675773021136 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8206370675773021136 where mk.keyword_id=aggView8206370675773021136.v19);
create or replace view aggJoin3746449192330058815 as (
with aggView2437114738269168657 as (select v49 from aggJoin7448837027195541303 group by v49)
select movie_id as v49, info_type_id as v17, info as v35 from movie_info_idx as mi_idx, aggView2437114738269168657 where mi_idx.movie_id=aggView2437114738269168657.v49);
create or replace view aggJoin2165901632859085374 as (
with aggView4298976826237882368 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView4298976826237882368 where mc.company_id=aggView4298976826237882368.v8);
create or replace view aggJoin3695438709411963205 as (
with aggView2190211831512655353 as (select v49 from aggJoin2165901632859085374 group by v49)
select id as v49, title as v50 from title as t, aggView2190211831512655353 where t.id=aggView2190211831512655353.v49);
create or replace view aggView399309050349488522 as select v49, v50 from aggJoin3695438709411963205 group by v49,v50;
create or replace view aggJoin7483401164281557402 as (
with aggView555312432387779114 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35 from aggJoin3746449192330058815 join aggView555312432387779114 using(v17));
create or replace view aggView4477674857774752446 as select v49, v35 from aggJoin7483401164281557402 group by v49,v35;
create or replace view aggJoin8252155194102604438 as (
with aggView7777056878852810661 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView7777056878852810661 where mi.info_type_id=aggView7777056878852810661.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView4628925153545118493 as select v49, v30 from aggJoin8252155194102604438 group by v49,v30;
create or replace view aggJoin6058252515161768474 as (
with aggView4854238735004004442 as (select v49, MIN(v50) as v64 from aggView399309050349488522 group by v49)
select v49, v30, v64 from aggView4628925153545118493 join aggView4854238735004004442 using(v49));
create or replace view aggJoin3710246878931200480 as (
with aggView2657428408192472090 as (select v49, MIN(v35) as v62 from aggView4477674857774752446 group by v49)
select v49, v30, v64 as v64, v62 from aggJoin6058252515161768474 join aggView2657428408192472090 using(v49));
create or replace view aggJoin4920575425821713301 as (
with aggView8874036549889043785 as (select v49, MIN(v64) as v64, MIN(v62) as v62, MIN(v30) as v61 from aggJoin3710246878931200480 group by v49,v64,v62)
select person_id as v40, note as v5, v64, v62, v61 from cast_info as ci, aggView8874036549889043785 where ci.movie_id=aggView8874036549889043785.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin543397111877179105 as (
with aggView2351965128007070547 as (select v40, MIN(v64) as v64, MIN(v62) as v62, MIN(v61) as v61 from aggJoin4920575425821713301 group by v40,v64,v61,v62)
select v41, v64, v62, v61 from aggView2919388054719129097 join aggView2351965128007070547 using(v40));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin543397111877179105;
