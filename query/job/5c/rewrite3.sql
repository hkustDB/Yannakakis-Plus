create or replace view aggView8773127207396901032 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2508704191002046894 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8773127207396901032 where mc.company_type_id=aggView8773127207396901032.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6373615962975354909 as select v15 from aggJoin2508704191002046894 group by v15;
create or replace view aggJoin9186644708099041169 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView6373615962975354909 where mi.movie_id=aggView6373615962975354909.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView284637384415131181 as select id as v3 from info_type as it;
create or replace view aggJoin2954518014389038965 as select v15, v13 from aggJoin9186644708099041169 join aggView284637384415131181 using(v3);
create or replace view aggView1929864612839161228 as select v15 from aggJoin2954518014389038965 group by v15;
create or replace view aggJoin1887412893873817375 as select title as v16 from title as t, aggView1929864612839161228 where t.id=aggView1929864612839161228.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin1887412893873817375;
