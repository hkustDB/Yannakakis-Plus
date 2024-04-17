create or replace view aggView6228742482400471239 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6440546539808104809 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6228742482400471239 where mc.movie_id=aggView6228742482400471239.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3441478563191040679 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4390128694361724705 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3441478563191040679 where mi_idx.info_type_id=aggView3441478563191040679.v3;
create or replace view aggView3599196746858794219 as select v15 from aggJoin4390128694361724705 group by v15;
create or replace view aggJoin6684133530784316152 as select v1, v9, v28 as v28, v29 as v29 from aggJoin6440546539808104809 join aggView3599196746858794219 using(v15);
create or replace view aggView3545861835218844452 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin889666380344151147 as select v9, v28, v29 from aggJoin6684133530784316152 join aggView3545861835218844452 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin889666380344151147;
