create or replace view aggView1714696688176181145 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2062226409455575657 as select movie_id as v14 from movie_keyword as mk, aggView1714696688176181145 where mk.keyword_id=aggView1714696688176181145.v3;
create or replace view aggView2327926786008532373 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4870791155426339967 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2327926786008532373 where mi_idx.info_type_id=aggView2327926786008532373.v1 and info>'5.0';
create or replace view aggView9148110270576391437 as select v14 from aggJoin2062226409455575657 group by v14;
create or replace view aggJoin5082256404021190687 as select v14, v9 from aggJoin4870791155426339967 join aggView9148110270576391437 using(v14);
create or replace view aggView5534949823726632156 as select v14, MIN(v9) as v26 from aggJoin5082256404021190687 group by v14;
create or replace view aggJoin8946460209502596089 as select title as v15, v26 from title as t, aggView5534949823726632156 where t.id=aggView5534949823726632156.v14 and production_year>2005;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8946460209502596089;
