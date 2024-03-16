create or replace view aggView4712922375912443914 as select id as v3 from info_type as it;
create or replace view aggJoin2958799648459338907 as select movie_id as v15, info as v13 from movie_info as mi, aggView4712922375912443914 where mi.info_type_id=aggView4712922375912443914.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4559994644005463346 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8021863965422003520 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4559994644005463346 where mc.company_type_id=aggView4559994644005463346.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView9193583024311040230 as select v15 from aggJoin8021863965422003520 group by v15;
create or replace view aggJoin7637081380764320871 as select v15, v13 from aggJoin2958799648459338907 join aggView9193583024311040230 using(v15);
create or replace view aggView6860313430479092276 as select v15 from aggJoin7637081380764320871 group by v15;
create or replace view aggJoin4145585804481193439 as select title as v16 from title as t, aggView6860313430479092276 where t.id=aggView6860313430479092276.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin4145585804481193439;
