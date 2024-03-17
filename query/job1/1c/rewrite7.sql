create or replace view aggView9098728256985183645 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin4920781894171828886 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView9098728256985183645 where mi_idx.movie_id=aggView9098728256985183645.v15;
create or replace view aggView1420803138776770046 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8815760281184382902 as select v15, v28, v29 from aggJoin4920781894171828886 join aggView1420803138776770046 using(v3);
create or replace view aggView6703027897809249280 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin8815760281184382902 group by v15;
create or replace view aggJoin7686475144965378771 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6703027897809249280 where mc.movie_id=aggView6703027897809249280.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8041009567821401770 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin7686475144965378771 group by v1;
create or replace view aggJoin1594478917148510868 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8041009567821401770 where ct.id=aggView8041009567821401770.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1594478917148510868;
