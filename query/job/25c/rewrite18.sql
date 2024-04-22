create or replace view aggView8308612181108134354 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView7246874088583860849 as select id as v37, title as v38 from title as t;
create or replace view aggJoin3644834482123898827 as (
with aggView5333870423507952941 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5333870423507952941 where mi_idx.info_type_id=aggView5333870423507952941.v10);
create or replace view aggView2521156000997633847 as select v37, v23 from aggJoin3644834482123898827 group by v37,v23;
create or replace view aggJoin2530415705580836352 as (
with aggView6986877666905441115 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6986877666905441115 where mi.info_type_id=aggView6986877666905441115.v8);
create or replace view aggJoin4786488050284855598 as (
with aggView8584995474107081255 as (select v37, v18 from aggJoin2530415705580836352 group by v37,v18)
select v37, v18 from aggView8584995474107081255 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1124762691036749951 as (
with aggView7556187372146171677 as (select v37, MIN(v18) as v49 from aggJoin4786488050284855598 group by v37)
select v37, v23, v49 from aggView2521156000997633847 join aggView7556187372146171677 using(v37));
create or replace view aggJoin2373319342242297955 as (
with aggView7778749898333564028 as (select v37, MIN(v38) as v52 from aggView7246874088583860849 group by v37)
select v37, v23, v49 as v49, v52 from aggJoin1124762691036749951 join aggView7778749898333564028 using(v37));
create or replace view aggJoin7303262064794211396 as (
with aggView4639741278695025974 as (select v28, MIN(v29) as v51 from aggView8308612181108134354 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView4639741278695025974 where ci.person_id=aggView4639741278695025974.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8484279698552120497 as (
with aggView997012104654044047 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView997012104654044047 where mk.keyword_id=aggView997012104654044047.v12);
create or replace view aggJoin1584175647753470319 as (
with aggView2011539334446148685 as (select v37 from aggJoin8484279698552120497 group by v37)
select v37, v5, v51 as v51 from aggJoin7303262064794211396 join aggView2011539334446148685 using(v37));
create or replace view aggJoin5465356424761872434 as (
with aggView3312807654966224037 as (select v37, MIN(v51) as v51 from aggJoin1584175647753470319 group by v37,v51)
select v23, v49 as v49, v52 as v52, v51 from aggJoin2373319342242297955 join aggView3312807654966224037 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5465356424761872434;
