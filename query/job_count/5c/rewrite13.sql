create or replace view aggView4329812441096907196 as select id as v3 from info_type as it;
create or replace view aggJoin6470947806989281571 as select movie_id as v15, info as v13 from movie_info as mi, aggView4329812441096907196 where mi.info_type_id=aggView4329812441096907196.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7599276723498101027 as select v15, COUNT(*) as annot from aggJoin6470947806989281571 group by v15;
create or replace view aggJoin2137049720260372916 as select movie_id as v15, company_type_id as v1, note as v9, annot from movie_companies as mc, aggView7599276723498101027 where mc.movie_id=aggView7599276723498101027.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5419575703709051088 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3568210171036795027 as select v15, v9, annot from aggJoin2137049720260372916 join aggView5419575703709051088 using(v1);
create or replace view aggView416052520432298150 as select v15, SUM(annot) as annot from aggJoin3568210171036795027 group by v15;
create or replace view aggJoin8943642088304768125 as select annot from title as t, aggView416052520432298150 where t.id=aggView416052520432298150.v15 and production_year>1990;
select SUM(annot) as v27 from aggJoin8943642088304768125;
