create or replace view aggView2156505716613128572 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin1660906904711813781 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView2156505716613128572 where mi.movie_id=aggView2156505716613128572.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5236082939146727853 as select id as v3 from info_type as it;
create or replace view aggJoin2721252831438104310 as select v15, v13, v27 from aggJoin1660906904711813781 join aggView5236082939146727853 using(v3);
create or replace view aggView619140659051124113 as select v15, MIN(v27) as v27 from aggJoin2721252831438104310 group by v15;
create or replace view aggJoin6341727185352333310 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView619140659051124113 where mc.movie_id=aggView619140659051124113.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4091285870441326201 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9217117859750449698 as select v9, v27 from aggJoin6341727185352333310 join aggView4091285870441326201 using(v1);
select MIN(v27) as v27 from aggJoin9217117859750449698;
