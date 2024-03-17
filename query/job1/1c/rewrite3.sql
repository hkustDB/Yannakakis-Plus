create or replace view aggView936446876360385291 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7985981631385001755 as select movie_id as v15, note as v9 from movie_companies as mc, aggView936446876360385291 where mc.company_type_id=aggView936446876360385291.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView2988216095362196534 as select v15, MIN(v9) as v27 from aggJoin7985981631385001755 group by v15;
create or replace view aggJoin1331257213106409567 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2988216095362196534 where t.id=aggView2988216095362196534.v15 and production_year>2010;
create or replace view aggView878723194338404508 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin1331257213106409567 group by v15;
create or replace view aggJoin421151924507415988 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView878723194338404508 where mi_idx.movie_id=aggView878723194338404508.v15;
create or replace view aggView6138883385795791778 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin953785733430772602 as select v27, v28, v29 from aggJoin421151924507415988 join aggView6138883385795791778 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin953785733430772602;
