create or replace view aggView5440087764189612529 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView5618905657026028095 as select id as v37, title as v38 from title as t;
create or replace view aggJoin7784785005714200639 as (
with aggView5317798238337851572 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5317798238337851572 where mi_idx.info_type_id=aggView5317798238337851572.v10);
create or replace view aggView2790871395051164464 as select v37, v23 from aggJoin7784785005714200639 group by v37,v23;
create or replace view aggJoin1771093240150914335 as (
with aggView3953111719749292152 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3953111719749292152 where mi.info_type_id=aggView3953111719749292152.v8);
create or replace view aggJoin7898526930005634045 as (
with aggView4823520789794523528 as (select v37, v18 from aggJoin1771093240150914335 group by v37,v18)
select v37, v18 from aggView4823520789794523528 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1313441548277418975 as (
with aggView7639046190491115717 as (select v37, MIN(v18) as v49 from aggJoin7898526930005634045 group by v37)
select v37, v38, v49 from aggView5618905657026028095 join aggView7639046190491115717 using(v37));
create or replace view aggJoin4488433315236338027 as (
with aggView2095346552071234479 as (select v37, MIN(v49) as v49, MIN(v38) as v52 from aggJoin1313441548277418975 group by v37,v49)
select person_id as v28, movie_id as v37, note as v5, v49, v52 from cast_info as ci, aggView2095346552071234479 where ci.movie_id=aggView2095346552071234479.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5047931578015742293 as (
with aggView1199475542737546787 as (select v28, MIN(v29) as v51 from aggView5440087764189612529 group by v28)
select v37, v5, v49 as v49, v52 as v52, v51 from aggJoin4488433315236338027 join aggView1199475542737546787 using(v28));
create or replace view aggJoin5066613101541878347 as (
with aggView6216989925312401172 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView6216989925312401172 where mk.keyword_id=aggView6216989925312401172.v12);
create or replace view aggJoin1774375649017633013 as (
with aggView5651029057616760882 as (select v37 from aggJoin5066613101541878347 group by v37)
select v37, v5, v49 as v49, v52 as v52, v51 as v51 from aggJoin5047931578015742293 join aggView5651029057616760882 using(v37));
create or replace view aggJoin5344785369269288226 as (
with aggView4996657591042234318 as (select v37, MIN(v49) as v49, MIN(v52) as v52, MIN(v51) as v51 from aggJoin1774375649017633013 group by v37,v49,v52,v51)
select v23, v49, v52, v51 from aggView2790871395051164464 join aggView4996657591042234318 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5344785369269288226;
