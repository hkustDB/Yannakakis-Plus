create or replace view aggView1316363017692901892 as select title as v38, id as v37 from title as t;
create or replace view aggView9046998318107408070 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin280310887823671906 as (
with aggView5888165323128574556 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView5888165323128574556 where mi_idx.info_type_id=aggView5888165323128574556.v10);
create or replace view aggJoin5144763289865510598 as (
with aggView7420507219287701851 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView7420507219287701851 where mi.info_type_id=aggView7420507219287701851.v8);
create or replace view aggJoin4645555064741471684 as (
with aggView7241707025517939765 as (select v18, v37 from aggJoin5144763289865510598 group by v18,v37)
select v37, v18 from aggView7241707025517939765 where v18= 'Horror');
create or replace view aggJoin3272438914431294868 as (
with aggView6390200444024847278 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView6390200444024847278 where mk.keyword_id=aggView6390200444024847278.v12);
create or replace view aggJoin2190342888514455556 as (
with aggView2008237885228440990 as (select v37 from aggJoin3272438914431294868 group by v37)
select v37, v23 from aggJoin280310887823671906 join aggView2008237885228440990 using(v37));
create or replace view aggView3712101635531894648 as select v23, v37 from aggJoin2190342888514455556 group by v23,v37;
create or replace view aggJoin8674474968915733872 as (
with aggView5774628763086914875 as (select v28, MIN(v29) as v51 from aggView9046998318107408070 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5774628763086914875 where ci.person_id=aggView5774628763086914875.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5905499443406116380 as (
with aggView7961655044528734672 as (select v37, MIN(v18) as v49 from aggJoin4645555064741471684 group by v37)
select v38, v37, v49 from aggView1316363017692901892 join aggView7961655044528734672 using(v37));
create or replace view aggJoin9100586056988333773 as (
with aggView1853416841333701578 as (select v37, MIN(v51) as v51 from aggJoin8674474968915733872 group by v37,v51)
select v38, v37, v49 as v49, v51 from aggJoin5905499443406116380 join aggView1853416841333701578 using(v37));
create or replace view aggJoin2417238987487190622 as (
with aggView6107031072088785288 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v38) as v52 from aggJoin9100586056988333773 group by v37,v51,v49)
select v23, v49, v51, v52 from aggView3712101635531894648 join aggView6107031072088785288 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin2417238987487190622;
