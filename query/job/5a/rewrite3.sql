create or replace view aggView5180549784391319964 as select id as v3 from info_type as it;
create or replace view aggJoin4798025981767515421 as select movie_id as v15, info as v13 from movie_info as mi, aggView5180549784391319964 where mi.info_type_id=aggView5180549784391319964.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4492908790566242260 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7437963660522898938 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4492908790566242260 where mc.company_type_id=aggView4492908790566242260.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView151700582516452760 as select v15 from aggJoin4798025981767515421 group by v15;
create or replace view aggJoin457644031073659233 as select id as v15, title as v16, production_year as v19 from title as t, aggView151700582516452760 where t.id=aggView151700582516452760.v15 and production_year>2005;
create or replace view aggView1332327688788057940 as select v15 from aggJoin7437963660522898938 group by v15;
create or replace view aggJoin8629717911957184663 as select v16 from aggJoin457644031073659233 join aggView1332327688788057940 using(v15);
select MIN(v16) as v27 from aggJoin8629717911957184663;
