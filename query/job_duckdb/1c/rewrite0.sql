create or replace view aggView2924829838219561057 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1405070366169951263 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2924829838219561057 where mi_idx.info_type_id=aggView2924829838219561057.v3;
create or replace view aggView7502928371771818786 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5616730937392762561 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7502928371771818786 where mc.company_type_id=aggView7502928371771818786.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6190058586279099769 as select v15 from aggJoin1405070366169951263 group by v15;
create or replace view aggJoin8587592505859213161 as select v15, v9 from aggJoin5616730937392762561 join aggView6190058586279099769 using(v15);
create or replace view aggView3362558771454331889 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin1714401823929872209 as select v9, v28, v29 from aggJoin8587592505859213161 join aggView3362558771454331889 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1714401823929872209;
