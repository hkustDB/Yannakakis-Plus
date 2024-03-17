create or replace view aggView5870845165393410040 as select id as v3 from info_type as it;
create or replace view aggJoin2952612394752508463 as select movie_id as v15, info as v13 from movie_info as mi, aggView5870845165393410040 where mi.info_type_id=aggView5870845165393410040.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6066884897863831792 as select v15 from aggJoin2952612394752508463 group by v15;
create or replace view aggJoin3399870275327191024 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView6066884897863831792 where mc.movie_id=aggView6066884897863831792.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3749165205678879332 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7643789488379347613 as select v15, v9 from aggJoin3399870275327191024 join aggView3749165205678879332 using(v1);
create or replace view aggView3496234964717896516 as select v15 from aggJoin7643789488379347613 group by v15;
create or replace view aggJoin6302610418205535355 as select title as v16 from title as t, aggView3496234964717896516 where t.id=aggView3496234964717896516.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin6302610418205535355;
