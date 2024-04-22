create or replace view aggView4436703987815743453 as select name as v41, id as v40 from name as n;
create or replace view aggView5304891744198406782 as select id as v49, title as v50 from title as t;
create or replace view aggJoin4429652342964164401 as (
with aggView2911154809784187951 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView2911154809784187951 where mk.keyword_id=aggView2911154809784187951.v19);
create or replace view aggJoin2344435176635006620 as (
with aggView4165691818488781258 as (select v49 from aggJoin4429652342964164401 group by v49)
select movie_id as v49, info_type_id as v17, info as v35 from movie_info_idx as mi_idx, aggView4165691818488781258 where mi_idx.movie_id=aggView4165691818488781258.v49);
create or replace view aggJoin3410997678308396471 as (
with aggView6675280952493524453 as (select id as v17 from info_type as it2 where info= 'votes')
select v49, v35 from aggJoin2344435176635006620 join aggView6675280952493524453 using(v17));
create or replace view aggView5498272838099975983 as select v49, v35 from aggJoin3410997678308396471 group by v49,v35;
create or replace view aggJoin6818272543320255829 as (
with aggView2767092825578381839 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView2767092825578381839 where mi.info_type_id=aggView2767092825578381839.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView4329770829105613806 as select v49, v30 from aggJoin6818272543320255829 group by v49,v30;
create or replace view aggJoin684329661699240451 as (
with aggView2932472117401206871 as (select v40, MIN(v41) as v63 from aggView4436703987815743453 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView2932472117401206871 where ci.person_id=aggView2932472117401206871.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7153101200943058249 as (
with aggView1468229465535957417 as (select v49, MIN(v35) as v62 from aggView5498272838099975983 group by v49)
select v49, v30, v62 from aggView4329770829105613806 join aggView1468229465535957417 using(v49));
create or replace view aggJoin6151769265160268768 as (
with aggView7420508505991615056 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView7420508505991615056 where mc.company_id=aggView7420508505991615056.v8);
create or replace view aggJoin6479109664110396715 as (
with aggView5753591340665986221 as (select v49 from aggJoin6151769265160268768 group by v49)
select v49, v5, v63 as v63 from aggJoin684329661699240451 join aggView5753591340665986221 using(v49));
create or replace view aggJoin7088568281294801473 as (
with aggView6036394265580102872 as (select v49, MIN(v63) as v63 from aggJoin6479109664110396715 group by v49,v63)
select v49, v30, v62 as v62, v63 from aggJoin7153101200943058249 join aggView6036394265580102872 using(v49));
create or replace view aggJoin1772712860685116632 as (
with aggView5668623356724506115 as (select v49, MIN(v62) as v62, MIN(v63) as v63, MIN(v30) as v61 from aggJoin7088568281294801473 group by v49,v63,v62)
select v50, v62, v63, v61 from aggView5304891744198406782 join aggView5668623356724506115 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin1772712860685116632;
