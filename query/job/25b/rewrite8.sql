create or replace view aggView7656120148889347518 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin5007020596946624745 as (
with aggView2264571894905023646 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView2264571894905023646 where v38 LIKE 'Vampire%');
create or replace view aggJoin1525570652677891721 as (
with aggView6069724830667087634 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6069724830667087634 where mi.info_type_id=aggView6069724830667087634.v8 and info= 'Horror');
create or replace view aggView7771018056243004724 as select v18, v37 from aggJoin1525570652677891721 group by v18,v37;
create or replace view aggJoin7525856468971148328 as (
with aggView4746491496718569146 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView4746491496718569146 where mk.keyword_id=aggView4746491496718569146.v12);
create or replace view aggJoin2765328830419317039 as (
with aggView2897740608981588145 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2897740608981588145 where mi_idx.info_type_id=aggView2897740608981588145.v10);
create or replace view aggJoin3725894162017716948 as (
with aggView8677114961631133641 as (select v37 from aggJoin7525856468971148328 group by v37)
select v37, v23 from aggJoin2765328830419317039 join aggView8677114961631133641 using(v37));
create or replace view aggView1046355716124518966 as select v23, v37 from aggJoin3725894162017716948 group by v23,v37;
create or replace view aggJoin6813944241022689800 as (
with aggView3770156079251400075 as (select v28, MIN(v29) as v51 from aggView7656120148889347518 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3770156079251400075 where ci.person_id=aggView3770156079251400075.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin148490807846965322 as (
with aggView5666510968829368686 as (select v37, MIN(v23) as v50 from aggView1046355716124518966 group by v37)
select v18, v37, v50 from aggView7771018056243004724 join aggView5666510968829368686 using(v37));
create or replace view aggJoin8612552389970584360 as (
with aggView8584366359586273053 as (select v37, MIN(v51) as v51 from aggJoin6813944241022689800 group by v37,v51)
select v37, v38, v51 from aggJoin5007020596946624745 join aggView8584366359586273053 using(v37));
create or replace view aggJoin7522425286215564071 as (
with aggView5220878521069157537 as (select v37, MIN(v51) as v51, MIN(v38) as v52 from aggJoin8612552389970584360 group by v37,v51)
select v18, v50 as v50, v51, v52 from aggJoin148490807846965322 join aggView5220878521069157537 using(v37));
select MIN(v18) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7522425286215564071;
