package Beans;

import Hibernate.HibernateUtil;
import Mapeos.Cliente;
import Mapeos.Compra;
import Mapeos.Producto;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class CompraDAO {

    private Session sesion;
    private Transaction tx;

    public CompraDAO() {
    }

    public int guardaCompra(Compra compra) throws HibernateException {
        int id = -1;

        try {
            iniciaOperacion();
            id = (Integer) sesion.save(compra);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.close();
        }
        return id;
    }

    public void eliminaCompra(int compraNo) {
        try {
            iniciaOperacion();
            Compra compra = (Compra) sesion.get(Compra.class, compraNo);
            sesion.delete(compra);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            sesion.close();
        }
    }

    public Compra obtenCompra(int noCompra) throws HibernateException {
        Compra compra = null;
        try {
            iniciaOperacion();
            compra = (Compra) sesion.get(Compra.class, noCompra);
        } finally {
            sesion.close();
        }
        return compra;
    }

    public List<Compra> obtenListaCompra() throws HibernateException {
        List<Compra> listaCompras = null;
        try {
            iniciaOperacion();  // Inicia la sesión de Hibernate
            listaCompras = sesion.createQuery("from Compra").list();
            tx.commit();  // Confirma la transacción
        } catch (HibernateException he) {
            manejaExcepcion(he);  // Manejo de errores
        } finally {
            if (sesion != null) {
                sesion.close();  // Asegúrate de cerrar la sesión
            }
        }
        return listaCompras;
    }

public List<List> compraPorCliente(int clienteId) throws HibernateException {
    List<Compra> comprasDelCliente = null;
    List<List> classified = new ArrayList<>(); // Use the diamond operator <>

    try {
        iniciaOperacion();

        // 1. EFFICIENT & SAFE QUERY: Fetch ONLY the purchases for the specified client.
        // Use a parameterized query to prevent HQL Injection.
        comprasDelCliente = sesion.createQuery("from Compra where idCliente = :cId", Compra.class)
                                 .setParameter("cId", clienteId)
                                 .getResultList(); // Modern way to get a list

        // This part of your logic seems to want to group purchases by a "numero".
        // A more robust way is to use a Map. Let's assume you want to group them.
        // If you just need one big list, you can skip the grouping.
        
        // This example will just put all purchases into one list for simplicity.
        // If you need to group them, the logic would be more complex (e.g., using a Map).
        if (comprasDelCliente != null && !comprasDelCliente.isEmpty()) {
            
            ProductoDAO productoDao = new ProductoDAO();
            for(Compra compra : comprasDelCliente){
                Producto prod = productoDao.obtenProducto(compra.getIdProducto());
                compra.setProducto(prod);
            }
            
            // Just add the single list of all their purchases.
            classified.add(comprasDelCliente);
        }

        tx.commit();
    } catch (HibernateException ex) {
        manejaExcepcion(ex);
        throw ex;
    } finally {
        if (sesion != null && sesion.isOpen()) { // Check if session is open before closing
            sesion.close();
        }
    }
    return classified;
}

    public int actualizaCompra(Compra compra) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(compra);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return 0;
    }

    private void iniciaOperacion() {
        try {
            sesion = HibernateUtil.getSessionFactory().openSession();
            tx = sesion.beginTransaction();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        tx.rollback();
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }
}
