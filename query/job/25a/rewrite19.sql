create or replace view aggJoin3542545112294991310 as (
with aggView242288796597866333 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView242288796597866333 where ci.person_id=aggView242288796597866333.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4801414509165185379 as (
with aggView2187748242900239848 as (select id as v37, title as v52 from title as t)
select v37, v5, v51, v52 from aggJoin3542545112294991310 join aggView2187748242900239848 using(v37));
create or replace view aggJoin3052505210097044900 as (
with aggView4597661786135585933 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4597661786135585933 where mi_idx.info_type_id=aggView4597661786135585933.v10);
create or replace view aggJoin5347735861585673132 as (
with aggView6625006610744696950 as (select v37, MIN(v23) as v50 from aggJoin3052505210097044900 group by v37)
select v37, v5, v51 as v51, v52 as v52, v50 from aggJoin4801414509165185379 join aggView6625006610744696950 using(v37));
create or replace view aggJoin6694189284184447080 as (
with aggView8693539522404264847 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView8693539522404264847 where mk.keyword_id=aggView8693539522404264847.v12);
create or replace view aggJoin168574750784615961 as (
with aggView8540264283125779528 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView8540264283125779528 where mi.info_type_id=aggView8540264283125779528.v8 and info= 'Horror');
create or replace view aggJoin649356615132964923 as (
with aggView1602670299209126136 as (select v37, MIN(v18) as v49 from aggJoin168574750784615961 group by v37)
select v37, v5, v51 as v51, v52 as v52, v50 as v50, v49 from aggJoin5347735861585673132 join aggView1602670299209126136 using(v37));
create or replace view aggJoin3872759032766313258 as (
with aggView3463625813340548465 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v50) as v50, MIN(v49) as v49 from aggJoin649356615132964923 group by v37,v51,v49,v50,v52)
select v51, v52, v50, v49 from aggJoin6694189284184447080 join aggView3463625813340548465 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin3872759032766313258;
