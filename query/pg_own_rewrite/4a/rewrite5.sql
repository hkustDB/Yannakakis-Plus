create or replace view aggView1910102526493336904 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1093615939844982279 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1910102526493336904 where mi_idx.info_type_id=aggView1910102526493336904.v1 and info>'5.0';
create or replace view aggView5735754009482200085 as select v14, MIN(v9) as v26 from aggJoin1093615939844982279 group by v14;
create or replace view aggJoin305492428603574148 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView5735754009482200085 where t.id=aggView5735754009482200085.v14 and production_year>2005;
create or replace view aggView56317981571450610 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6451219448984232798 as select movie_id as v14 from movie_keyword as mk, aggView56317981571450610 where mk.keyword_id=aggView56317981571450610.v3;
create or replace view aggView2217190792886311721 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin305492428603574148 group by v14,v26;
create or replace view aggJoin949672995421424834 as select v26, v27 from aggJoin6451219448984232798 join aggView2217190792886311721 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin949672995421424834;
