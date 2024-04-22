create or replace view aggView8356032818522845692 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin2862206493898647075 as (
with aggView4060932836687768104 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView4060932836687768104 where mk.keyword_id=aggView4060932836687768104.v19);
create or replace view aggJoin4489134680687169643 as (
with aggView4326036810027078651 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4326036810027078651 where mi_idx.info_type_id=aggView4326036810027078651.v17);
create or replace view aggJoin7079120256292108266 as (
with aggView334707588388589093 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView334707588388589093 where mi.info_type_id=aggView334707588388589093.v15);
create or replace view aggJoin6631784446799566039 as (
with aggView7209154393074795403 as (select v30, v49 from aggJoin7079120256292108266 group by v30,v49)
select v49, v30 from aggView7209154393074795403 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin3631517247015470776 as (
with aggView3109546861038272277 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView3109546861038272277 where mc.company_id=aggView3109546861038272277.v8);
create or replace view aggJoin3418435609461508018 as (
with aggView4178974288240527010 as (select v49 from aggJoin2862206493898647075 group by v49)
select v49, v35 from aggJoin4489134680687169643 join aggView4178974288240527010 using(v49));
create or replace view aggView5609421121703991404 as select v49, v35 from aggJoin3418435609461508018 group by v49,v35;
create or replace view aggJoin848487166419149882 as (
with aggView3025319198633953885 as (select v49 from aggJoin3631517247015470776 group by v49)
select id as v49, title as v50 from title as t, aggView3025319198633953885 where t.id=aggView3025319198633953885.v49);
create or replace view aggView5898548493529981006 as select v50, v49 from aggJoin848487166419149882 group by v50,v49;
create or replace view aggJoin50062460170488678 as (
with aggView3132641472574855039 as (select v40, MIN(v41) as v63 from aggView8356032818522845692 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView3132641472574855039 where ci.person_id=aggView3132641472574855039.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1419625275021447905 as (
with aggView7181940952820872245 as (select v49, MIN(v30) as v61 from aggJoin6631784446799566039 group by v49)
select v50, v49, v61 from aggView5898548493529981006 join aggView7181940952820872245 using(v49));
create or replace view aggJoin234164784596336301 as (
with aggView4906494702516834563 as (select v49, MIN(v63) as v63 from aggJoin50062460170488678 group by v49,v63)
select v50, v49, v61 as v61, v63 from aggJoin1419625275021447905 join aggView4906494702516834563 using(v49));
create or replace view aggJoin2682902367161943570 as (
with aggView4091907934304285149 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v50) as v64 from aggJoin234164784596336301 group by v49,v61,v63)
select v35, v61, v63, v64 from aggView5609421121703991404 join aggView4091907934304285149 using(v49));
select MIN(v61) as v61,MIN(v35) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin2682902367161943570;
