create or replace view aggJoin7041589806575192855 as (
with aggView4349736645104683637 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView4349736645104683637 where ci.person_id=aggView4349736645104683637.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin9155491472028068224 as (
with aggView6574357518151951579 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView6574357518151951579 where mi_idx.info_type_id=aggView6574357518151951579.v10);
create or replace view aggJoin427801372472435518 as (
with aggView8410484483132242704 as (select v37, MIN(v23) as v50 from aggJoin9155491472028068224 group by v37)
select id as v37, title as v38, v50 from title as t, aggView8410484483132242704 where t.id=aggView8410484483132242704.v37);
create or replace view aggJoin1805977536948329448 as (
with aggView577341469413452612 as (select v37, MIN(v50) as v50, MIN(v38) as v52 from aggJoin427801372472435518 group by v37,v50)
select v37, v5, v51 as v51, v50, v52 from aggJoin7041589806575192855 join aggView577341469413452612 using(v37));
create or replace view aggJoin3373196733152817809 as (
with aggView3368662980985119600 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v52) as v52 from aggJoin1805977536948329448 group by v37,v50,v52,v51)
select movie_id as v37, info_type_id as v8, info as v18, v51, v50, v52 from movie_info as mi, aggView3368662980985119600 where mi.movie_id=aggView3368662980985119600.v37 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8460089257134559113 as (
with aggView5684929887256089030 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v51, v50, v52 from aggJoin3373196733152817809 join aggView5684929887256089030 using(v8));
create or replace view aggJoin408671970044816313 as (
with aggView120549616333866729 as (select v37, MIN(v51) as v51, MIN(v50) as v50, MIN(v52) as v52, MIN(v18) as v49 from aggJoin8460089257134559113 group by v37,v50,v52,v51)
select keyword_id as v12, v51, v50, v52, v49 from movie_keyword as mk, aggView120549616333866729 where mk.movie_id=aggView120549616333866729.v37);
create or replace view aggJoin1496385610302888063 as (
with aggView1093542563066584505 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select v51, v50, v52, v49 from aggJoin408671970044816313 join aggView1093542563066584505 using(v12));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1496385610302888063;
