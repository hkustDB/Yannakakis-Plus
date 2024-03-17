create or replace view aggView6754880188508370486 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6592369095314063788 as select movie_id as v12 from movie_keyword as mk, aggView6754880188508370486 where mk.keyword_id=aggView6754880188508370486.v18;
create or replace view aggView7730988807361054354 as select v12 from aggJoin6592369095314063788 group by v12;
create or replace view aggJoin7015727898028376013 as select id as v12, title as v20 from title as t, aggView7730988807361054354 where t.id=aggView7730988807361054354.v12;
create or replace view aggView3324225202547663121 as select v12, MIN(v20) as v31 from aggJoin7015727898028376013 group by v12;
create or replace view aggJoin1442863709283774924 as select company_id as v1, v31 from movie_companies as mc, aggView3324225202547663121 where mc.movie_id=aggView3324225202547663121.v12;
create or replace view aggView1273571014389547038 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin20335389069500545 as select v31 from aggJoin1442863709283774924 join aggView1273571014389547038 using(v1);
select MIN(v31) as v31 from aggJoin20335389069500545;
