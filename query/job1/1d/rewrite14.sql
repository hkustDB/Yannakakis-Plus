create or replace view aggView5844856339268321423 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin8437817488183235353 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5844856339268321423 where mc.movie_id=aggView5844856339268321423.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7054988105177135482 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1386175263375159754 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7054988105177135482 where mi_idx.info_type_id=aggView7054988105177135482.v3;
create or replace view aggView5712629659498551687 as select v15 from aggJoin1386175263375159754 group by v15;
create or replace view aggJoin1301662255203594132 as select v1, v9, v28 as v28, v29 as v29 from aggJoin8437817488183235353 join aggView5712629659498551687 using(v15);
create or replace view aggView8461873823972006059 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6183672509216901070 as select v9, v28, v29 from aggJoin1301662255203594132 join aggView8461873823972006059 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6183672509216901070;
