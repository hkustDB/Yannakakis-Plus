create or replace view aggView7213110794408025398 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6689328859093192661 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView7213110794408025398 where mc.movie_id=aggView7213110794408025398.v12;
create or replace view aggView6664825353061630320 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4277886824041369288 as select v12, v31 from aggJoin6689328859093192661 join aggView6664825353061630320 using(v1);
create or replace view aggView7507520404692885088 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3765204440774302896 as select movie_id as v12 from movie_keyword as mk, aggView7507520404692885088 where mk.keyword_id=aggView7507520404692885088.v18;
create or replace view aggView6961480495775353020 as select v12, MIN(v31) as v31 from aggJoin4277886824041369288 group by v12,v31;
create or replace view aggJoin8050183422732057412 as select v31 from aggJoin3765204440774302896 join aggView6961480495775353020 using(v12);
select MIN(v31) as v31 from aggJoin8050183422732057412;
