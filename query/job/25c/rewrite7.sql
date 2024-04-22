create or replace view aggView7476929315409608638 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin3454624465220098131 as (
with aggView1661574915120390009 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView1661574915120390009 where mi_idx.info_type_id=aggView1661574915120390009.v10);
create or replace view aggView7123773678182387229 as select v37, v23 from aggJoin3454624465220098131 group by v37,v23;
create or replace view aggJoin4208458002995218263 as (
with aggView1829443209435870315 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1829443209435870315 where mi.info_type_id=aggView1829443209435870315.v8);
create or replace view aggJoin6457205297195695657 as (
with aggView6485361400388910736 as (select v37, v18 from aggJoin4208458002995218263 group by v37,v18)
select v37, v18 from aggView6485361400388910736 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6576726383749682552 as (
with aggView2385536305632153921 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView2385536305632153921 where mk.keyword_id=aggView2385536305632153921.v12);
create or replace view aggJoin5204535506248127669 as (
with aggView2983594402882140391 as (select v37 from aggJoin6576726383749682552 group by v37)
select id as v37, title as v38 from title as t, aggView2983594402882140391 where t.id=aggView2983594402882140391.v37);
create or replace view aggView6104796376453719015 as select v37, v38 from aggJoin5204535506248127669 group by v37,v38;
create or replace view aggJoin4347617091093641238 as (
with aggView7806721402313856434 as (select v28, MIN(v29) as v51 from aggView7476929315409608638 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView7806721402313856434 where ci.person_id=aggView7806721402313856434.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7347636919208495950 as (
with aggView3108377324000219575 as (select v37, MIN(v38) as v52 from aggView6104796376453719015 group by v37)
select v37, v23, v52 from aggView7123773678182387229 join aggView3108377324000219575 using(v37));
create or replace view aggJoin1110882457344589212 as (
with aggView8144640270766109982 as (select v37, MIN(v51) as v51 from aggJoin4347617091093641238 group by v37,v51)
select v37, v18, v51 from aggJoin6457205297195695657 join aggView8144640270766109982 using(v37));
create or replace view aggJoin5265286146440946392 as (
with aggView13902095156273001 as (select v37, MIN(v51) as v51, MIN(v18) as v49 from aggJoin1110882457344589212 group by v37,v51)
select v23, v52 as v52, v51, v49 from aggJoin7347636919208495950 join aggView13902095156273001 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin5265286146440946392;
