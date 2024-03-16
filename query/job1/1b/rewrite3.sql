create or replace view aggView7441108025627922460 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6985373537630319641 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7441108025627922460 where mc.company_type_id=aggView7441108025627922460.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView133664626759771475 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1219169802149452124 as select movie_id as v15 from movie_info_idx as mi_idx, aggView133664626759771475 where mi_idx.info_type_id=aggView133664626759771475.v3;
create or replace view aggView6118065396121089454 as select v15 from aggJoin1219169802149452124 group by v15;
create or replace view aggJoin1568353033434595424 as select v15, v9 from aggJoin6985373537630319641 join aggView6118065396121089454 using(v15);
create or replace view aggView7439048878998271913 as select v15, MIN(v9) as v27 from aggJoin1568353033434595424 group by v15;
create or replace view aggJoin5131573276381744958 as select title as v16, production_year as v19, v27 from title as t, aggView7439048878998271913 where t.id=aggView7439048878998271913.v15 and production_year<=2010 and production_year>=2005;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5131573276381744958;
