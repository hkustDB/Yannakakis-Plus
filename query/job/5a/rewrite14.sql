create or replace view aggView8006423767167992511 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8556713962257433421 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8006423767167992511 where mi.movie_id=aggView8006423767167992511.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2937126904209862310 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2246522185218542690 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2937126904209862310 where mc.company_type_id=aggView2937126904209862310.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2175298340342912103 as select v15 from aggJoin2246522185218542690 group by v15;
create or replace view aggJoin2162280402341174377 as select v3, v13, v27 as v27 from aggJoin8556713962257433421 join aggView2175298340342912103 using(v15);
create or replace view aggView5251148317299915231 as select id as v3 from info_type as it;
create or replace view aggJoin4717994390472792950 as select v13, v27 from aggJoin2162280402341174377 join aggView5251148317299915231 using(v3);
select MIN(v27) as v27 from aggJoin4717994390472792950;
