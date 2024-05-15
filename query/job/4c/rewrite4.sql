create or replace view aggView7044323402788050884 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin273385391757989860 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7044323402788050884 where mi_idx.info_type_id=aggView7044323402788050884.v1 and info>'2.0';
create or replace view aggView7045618560279219076 as select v14, MIN(v9) as v26 from aggJoin273385391757989860 group by v14;
create or replace view aggJoin8019676795758142032 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView7045618560279219076 where t.id=aggView7045618560279219076.v14 and production_year>1990;
create or replace view aggView7137905639815889445 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3444629870443158246 as select movie_id as v14 from movie_keyword as mk, aggView7137905639815889445 where mk.keyword_id=aggView7137905639815889445.v3;
create or replace view aggView8401080108155133191 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8019676795758142032 group by v14;
create or replace view aggJoin5841742527518344000 as select v26, v27 from aggJoin3444629870443158246 join aggView8401080108155133191 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5841742527518344000;
