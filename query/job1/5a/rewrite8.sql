create or replace view aggView6568186211667757742 as select id as v3 from info_type as it;
create or replace view aggJoin3127733144598677758 as select movie_id as v15, info as v13 from movie_info as mi, aggView6568186211667757742 where mi.info_type_id=aggView6568186211667757742.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7282433909414264327 as select v15 from aggJoin3127733144598677758 group by v15;
create or replace view aggJoin1732303205735373941 as select id as v15, title as v16 from title as t, aggView7282433909414264327 where t.id=aggView7282433909414264327.v15 and production_year>2005;
create or replace view aggView49695575899746932 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9150702092010501593 as select movie_id as v15 from movie_companies as mc, aggView49695575899746932 where mc.company_type_id=aggView49695575899746932.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7587490574648535630 as select v15 from aggJoin9150702092010501593 group by v15;
create or replace view aggJoin2061013676351292983 as select v16 from aggJoin1732303205735373941 join aggView7587490574648535630 using(v15);
select MIN(v16) as v27 from aggJoin2061013676351292983;
