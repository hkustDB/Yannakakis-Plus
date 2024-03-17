create or replace view aggView864615387773826840 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin8709188941886724520 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView864615387773826840 where mi.movie_id=aggView864615387773826840.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8852698412508130115 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2384240560627936403 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8852698412508130115 where mc.company_type_id=aggView8852698412508130115.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4931656514884534009 as select v15 from aggJoin2384240560627936403 group by v15;
create or replace view aggJoin8633967328138274903 as select v3, v13, v27 as v27 from aggJoin8709188941886724520 join aggView4931656514884534009 using(v15);
create or replace view aggView5967810937789230358 as select id as v3 from info_type as it;
create or replace view aggJoin3527437852223251911 as select v13, v27 from aggJoin8633967328138274903 join aggView5967810937789230358 using(v3);
select MIN(v27) as v27 from aggJoin3527437852223251911;
