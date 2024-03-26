create or replace view aggView3030482993706563121 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4734002716081482335 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3030482993706563121 where mi_idx.info_type_id=aggView3030482993706563121.v1 and info>'5.0';
create or replace view aggView7942388270489299563 as select v14, MIN(v9) as v26 from aggJoin4734002716081482335 group by v14;
create or replace view aggJoin8420959624564449667 as select id as v14, title as v15, v26 from title as t, aggView7942388270489299563 where t.id=aggView7942388270489299563.v14 and production_year>2005;
create or replace view aggView7135969404454447800 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1625232560179611854 as select movie_id as v14 from movie_keyword as mk, aggView7135969404454447800 where mk.keyword_id=aggView7135969404454447800.v3;
create or replace view aggView2327481528244117050 as select v14 from aggJoin1625232560179611854 group by v14;
create or replace view aggJoin2360669168847134944 as select v15, v26 as v26 from aggJoin8420959624564449667 join aggView2327481528244117050 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin2360669168847134944;
