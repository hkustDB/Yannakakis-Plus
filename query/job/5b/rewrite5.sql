create or replace view aggView954780203306294773 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin1247996828306391923 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView954780203306294773 where mi.movie_id=aggView954780203306294773.v15 and info IN ('USA','America');
create or replace view aggView2187997579323884836 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin946004862372516165 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2187997579323884836 where mc.company_type_id=aggView2187997579323884836.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView9039662673564547769 as select v15 from aggJoin946004862372516165 group by v15;
create or replace view aggJoin737545842154563238 as select v3, v13, v27 as v27 from aggJoin1247996828306391923 join aggView9039662673564547769 using(v15);
create or replace view aggView1944398513090632354 as select id as v3 from info_type as it;
create or replace view aggJoin6071873072096038466 as select v27 from aggJoin737545842154563238 join aggView1944398513090632354 using(v3);
select MIN(v27) as v27 from aggJoin6071873072096038466;
