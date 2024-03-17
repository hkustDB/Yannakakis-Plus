create or replace view aggView268800078435585832 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin2522828359428776698 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView268800078435585832 where mi_idx.movie_id=aggView268800078435585832.v15;
create or replace view aggView8105845037343325192 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8885850219522445847 as select v15, v28, v29 from aggJoin2522828359428776698 join aggView8105845037343325192 using(v3);
create or replace view aggView610984465728310742 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin750905023952922231 as select movie_id as v15, note as v9 from movie_companies as mc, aggView610984465728310742 where mc.company_type_id=aggView610984465728310742.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView35897109395906067 as select v15, MIN(v9) as v27 from aggJoin750905023952922231 group by v15;
create or replace view aggJoin7667965173496984482 as select v28 as v28, v29 as v29, v27 from aggJoin8885850219522445847 join aggView35897109395906067 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7667965173496984482;
