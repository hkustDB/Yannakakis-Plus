create or replace view aggView6649517240965004041 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8126103670815298357 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6649517240965004041 where mc.company_type_id=aggView6649517240965004041.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2540938279130200659 as select v15 from aggJoin8126103670815298357 group by v15;
create or replace view aggJoin7670817740916460443 as select id as v15, title as v16 from title as t, aggView2540938279130200659 where t.id=aggView2540938279130200659.v15 and production_year>2005;
create or replace view aggView665887462886346860 as select v15, MIN(v16) as v27 from aggJoin7670817740916460443 group by v15;
create or replace view aggJoin8076608724533914583 as select info_type_id as v3, v27 from movie_info as mi, aggView665887462886346860 where mi.movie_id=aggView665887462886346860.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView836191512107692360 as select v3, MIN(v27) as v27 from aggJoin8076608724533914583 group by v3;
create or replace view aggJoin2027803015579325797 as select v27 from info_type as it, aggView836191512107692360 where it.id=aggView836191512107692360.v3;
select MIN(v27) as v27 from aggJoin2027803015579325797;
